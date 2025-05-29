# 使用官方 Python 輕量級映像
FROM python:3.9-slim

# 設置工作目錄
WORKDIR /app

# 先複製依賴文件 (這可以利用 Docker 緩存層優化構建)
COPY requirements.txt .

# 安裝依賴
RUN pip install --no-cache-dir -r requirements.txt

# 複製其餘應用文件
COPY . .

# 設置環境變量
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# 暴露端口 (Line Bot 通常使用 5000)
EXPOSE 5000

# 使用 Gunicorn 作為 WSGI 伺服器 (比 Flask 內建伺服器更適合生產環境)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "app:app"]