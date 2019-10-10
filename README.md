# capstone-2019

## Minimum Viable Product
### Discord Integration
* Communicates with Discord via bot - if C#: https://github.com/discord-net/Discord.Net
* When command is run (say `-spawn spider 1`) such an entity is spawned in game
### Game
* Survival game with obstacles spawned by discord users
* 2D Movement
* Crisp pixely base canvas

## Documentation
### Enemy Codes
| Name      | Value |
|-----------|-------|
| TestBlock | 0     |
### Networking
#### Discord Bot
Sends POST request to server to update server IDs request log
#### Game Server
Is polled by Game Client at regular intervals
#### Game Client
Run on players PC polls game server with network controller node
