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
ref https://www.youtube.com/watch?v=-n8allUvhw8
<br/>
Note:  the `RequestSerilizer()` can be replaced with any other type as long as it conforms to Serializer protocol.   
<br/>

<img width="766" alt="Screenshot 2021-03-31 at 22 34 33" src="https://user-images.githubusercontent.com/503469/113214414-5cc05380-9271-11eb-8962-2618759dfb73.png">




