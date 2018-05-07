from flask import Flask
from flask import request
from flask import render_template
from flask import make_response

app = Flask(__name__)
@app.route('/', methods=['GET'])
def index():
    # Chrome does not respect cache directives sometimes
    if request.headers.get("If-Modified-Since") != None:
        response = make_response(render_template("chrome_case.html"))
    elif request.cookies.get('user') == "root":
        response = make_response(render_template("third_case.html"))
    elif request.cookies.get('user') != None:
        user = request.cookies.get('user')
        response = make_response(render_template("second_case.html", user=user))
    else:
        user = "9DLSNOocmT4HjnAApG6JS0RXeX9XGhGK"
        response = make_response(render_template("first_case.html", user=user))
        response.set_cookie('user', user)
    # Setting a weak validator for Heuristic Caching for some time in the recent past
    response.headers["Last-Modified"] = "Sun, 21 May 1995 00:00:00 GMT"
    return response

if __name__ == "__main__":
    app.run(host='0.0.0.0')
