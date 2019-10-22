from aiohttp import web
import discord
from discord.ext import commands
import token

bot = commands.Bot(command_prefix='!')


class DiscordBot(commands.Cog):

    def __init__(self):
        self.to_send = None
        self.site = None

    async def enemy(self, request):
        res = {'enemy': self.to_send}
        return web.json_response(res)

    @commands.Cog.listener()
    async def on_ready(self):
        app = web.Application()
        app.add_routes([web.get('/', self.enemy)])
        runner = web.AppRunner(app)
        await runner.setup()
        self.site = web.TCPSite(runner, 'localhost', 8080)
        await self.site.start()

    @commands.command()
    async def addenemy(self, ctx, enemy: str):
        self.to_send = enemy
        await self.site.stop()
        await self.site.start()
        await ctx.send("Sent away!")


bot.add_cog(DiscordBot())
bot.run('token')

