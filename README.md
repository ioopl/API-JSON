# API-JSON
This Project is to fetch Football JSON Data from https://www.football-data.org

✅ The project makes use of Asynchronous calls,  @escaping closures for URLSession dataTask. 

✅ Using HTTP Auth Header token to authenticate the network requests.

✅ Unit Tests to Inject fake WebService and actuall ViewModel delegate method calls to test the WebService which returns Mock Data and the ViewModel Delegate obliges to update the UI.


How it all works ?
- The View (View Controller) initiates a ViewModel which is responsible to provide data to the View (via Delegate Method). 

- The ViewModel is is tested via Unit Tests and has no dependencies on Data Sources.

- The Data is fetched from the Web Service which is abstracted in its own class and provides data via its own delegate methods.


Whats left to do?

Make the App more accessible by adding Accessibility labels, traits and values and then Unit Test them using Accessibility Identifiers. 

Add more tests around the Data Web Service API calls.



<b> Example of Dependency Injection and Protocols used in the Project </b>
<br/>
Note:  the RequestSerilizer() can be replaced with any other type as long as it conforms to Serializer protocol   

![Screenshot 2021-03-31 at 20 40 53](https://user-images.githubusercontent.com/503469/113201648-a6a13d80-9261-11eb-8f4e-accb50105b40.png)



ref https://www.youtube.com/watch?v=-n8allUvhw8
