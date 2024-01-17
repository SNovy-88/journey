from locust import HttpUser, task

class MyUser(HttpUser):
    @task
    def go_to_homepage(self):
        self.client.get("http://localhost:8080/Journey_war_exploded/")
        
    @task
    def search_hike(self):
        self.client.get("http://localhost:8080/Journey_war_exploded/search.jsp")
        self.client.get("http://localhost:8080/Journey_war_exploded/loadingSpinner.jsp?searchString=kirchle")
        
    @task
    def search_all_hikes(self):
        self.client.get("http://localhost:8080/Journey_war_exploded/search.jsp")
        self.client.get("http://localhost:8080/Journey_war_exploded/searchResultList?searchString=")
        
    #@task
    #def user_login(self):
     #   self.client.get("http://localhost:8080/Journey_war_exploded/account.jsp")
      #  self.client.post("/login?username=admin&password=admin")
       # self.client.get("http://localhost:8080/Journey_war_exploded/success.jsp")
        
        
    @task
    def hike_detail_page(self):
        self.client.get("http://localhost:8080/Journey_war_exploded/search.jsp")
        self.client.get("http://localhost:8080/Journey_war_exploded/loadingSpinner.jsp?searchString=loo")
        self.client.get("http://localhost:8080/Journey_war_exploded/detailPage?hike-id=1")
        
    @task
    def filter_hikes(self):
        self.client.get("http://localhost:8080/Journey_war_exploded/search.jsp")
        self.client.get("http://localhost:8080/Journey_war_exploded/searchResultList?searchString=")
        self.client.get("http://localhost:8080/Journey_war_exploded/filterResultList?fitness-level=1&stamina=&experience=&scenery=&Jan=1&height-difference=&distance=12&duration-hr=&duration-min=&search-input-hidden=")