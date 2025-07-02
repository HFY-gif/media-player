from flask import request, jsonify
from extensions import app, db
from models import User, PlayRecord

@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    if not username or not password:
        return jsonify({'success': False, 'message': '用户名和密码不能为空'}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({'success': False, 'message': '用户名已存在'}), 409

    user = User(username=username, password=password)
    db.session.add(user)
    db.session.commit()
    return jsonify({'success': True, 'message': '注册成功'})

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    user = User.query.filter_by(username=username).first()
    if not user or user.password != password:
        return jsonify({'success': False, 'message': '用户名或密码错误'}), 401
    return jsonify({'success': True, 'user_id': user.user_id})

@app.route('/api/play_records', methods=['POST'])
def add_or_update_record():
    data = request.json
    user_id = data.get('user_id')
    media_type = data.get('media_type')
    media_id = data.get('media_id')
    media_title = data.get('media_title')
    media_url = data.get('media_url')
    duration = data.get('duration')

    if not all([user_id, media_type, media_id]):
        return jsonify({'success': False, 'message': '缺少必要字段'}), 400

    # 查找是否已有记录
    record = PlayRecord.query.filter_by(user_id=user_id, media_id=media_id).first()

    if record:
        # 如果已有，更新记录
        record.media_type = media_type
        record.media_title = media_title
        record.media_url = media_url
        record.duration = duration
        record.played_at = db.func.now()  # 更新时间
    else:
        # 新增记录
        record = PlayRecord(
            user_id=user_id,
            media_type=media_type,
            media_id=media_id,
            media_title=media_title,
            media_url=media_url,
            duration=duration
        )
        db.session.add(record)

    db.session.commit()
    return jsonify({'success': True, 'message': '播放记录添加/更新成功'})

@app.route('/api/play_records/<int:user_id>', methods=['GET'])
def get_records(user_id):
    records = PlayRecord.query.filter_by(user_id=user_id).order_by(PlayRecord.played_at.desc()).all()
    result = [
        {
            'record_id': r.record_id,
            'media_type': r.media_type,
            'media_id': r.media_id,
            'media_title': r.media_title,
            'media_url': r.media_url,  # 返回给前端
            'played_at': r.played_at.strftime('%Y-%m-%d %H:%M:%S'),
            'duration': r.duration
        } for r in records
    ]
    return jsonify({'success': True, 'records': result})
