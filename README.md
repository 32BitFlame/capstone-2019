# capstone-2019
## Documentation
### Networking
#### Discord Bot
Sends POST request to server to update server IDs request log
#### Game Server
Is polled by Game Client at regular intervals  
Test: https://repl.it/@BenjaminHouzeng/GameServer
#### Game Client
Run on players PC polls game server with network controller node
### Formatting
#### Indents
Indent Size: 4 (Tab)
Example:
```python
for x in range(10):
    #Code goes here
```
#### Naming Conventions
Most variables and functions use snake case for example:
```
var this_is_a_variable = 0;
```
Private variables and functions use the same format preceeded by an underscore (_)
```
var _private_variable = 0;
```
Constants are in snake case like most variables but in capital letters eg):
```
const THIS_IS_A_CONSTANT = 0;
```
Nodes are a unique case and use PascalCase as such:
```python
class MyNode():
```
