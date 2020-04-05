from locust import web


@web.app.route("/healthcheck")
def health_check():
    return "Success"
