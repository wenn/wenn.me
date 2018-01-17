---
title: Heroku, gunicorn and flask wsgi app.
updated: 2015-12-31 
---

A walk through and summarization of 
[Heroku's getting started guide](https://devcenter.heroku.com/articles/getting-started-with-python-o) 
to host a flask application on Heroku.

- **[wsgi](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface)**: A spefication that defines an interface for how web servers and web application communicated.
- **[gunicorn](http://gunicorn.org/)**: A wsgi implementation of a http server to handle http requests routing.
- **[flask](http://flask.pocoo.org/)**: The web framework where we will define our application logic based on incoming requests.
- **[heroku](https://www.heroku.com/)**: Where we will host our code and make it available on the open internet.

### 1. Prepping an isolated python environment

- We'll create a directory for our project and start up a new [virtualenv](https://virtualenv.readthedocs.org/en/latest/). This will give us an isolated python environment to play around in:

    ```bash
    mkdir goodbye
    cd goodbye
    virtualenv --no-site-packages venv
    source venv/bin/activate
    ```

- Create a **requirements.txt** file with contents:

    ```
    Flask==0.10.1
    gunicorn==19.4.3
    ```

- Then install them, in a terminal run..

    `pip install -r requirements.txt`

### 2. Create a simple goodbye flask app with gunicorn

- Create an **app.py** file under the **goodbye** directory with contents:

    ```python
    from flask import Flask

    app = Flask(__name__)

    @app.route('/')
    def goodbye():
        return 'Goodbye world...'
    ```

    Your directory should now look like this:

    ```
    /goodbye/
    ____ requirements.txt
    ____ app.py
    ```


- Start up the app on localhost! Your app should be available at localhost:8000. run...

    `gunicorn app:app --reload -b 127.0.0.1:8000`

    **--reload** will ask gunicorn to reload the server if there are any changes to  your flask app. **-b** binds our application to 127.0.0.1 address at port 8000

### 3. Add your project version control

- Using [git](https://git-scm.com/book/en/v2) we'll version control our project, run..

    ```bash
    git init
    git commit -m 'add a simple flask app with gunicorn'
    ```

- We'll also want to ignore a few things from version control. Create a **.gitignore** file with contents:

        venv
        *.pyc

    Your project should now look like this:

    ```
    /goodbye/
    ____ requirements.txt
    ____ app.py
    ____ .gitignore
    ```

### 4. Hosting our application on Heroku

- Login to heroku, you'll need to make an account. run...

    `heroku login`

- Create a heroku app with our project, heroku will gives us a random name. run...

    `heroku create`

- Give heroku instructions to start up our app. Create a **Procfile** file under the **goodbye** directory with contents:

    `web: gunicorn app:app --log-file=-`


    This tells heroku to start up the application with gunicorn on a web node where the application is hosted.
    Your directory should now look like this:

    ```
    /goodbye/
    ____ requirements.txt
    ____ app.py
    ____ Procfile
    ____ .gitignore
    ```


- Now we move our project up to the heroku platform. run...

    `git push heroku head`

- Once it's finish, we can open our hosted applpication. run...

    `heroku open`
