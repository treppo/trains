# Trains

My object oriented design evolved around the idea, that the city classes understand how they are connected and can work together (or "churn" as Fred George would say) to find routes using recursion. I identified two strategies to find routes: routes with a limited budget (number of stops or distance) and shortest routes to a destination. The current algorithm uses a depth–first approach. For larger graphs it might make sense to use lazy sequences to calculate the distance for a given route or a limited number of routes with a budget.

The test are written using Minitest, so opening the test file with ruby runs the test suite:
```shell
ruby test/test_city.rb
```
