from aiohttp import web
import discord
from discord.ext import commands


bot = commands.Bot(command_prefix='!')
routes = web.RouteTableDef()
to_send = None

@routes.get('/')
async def enemy(request):
    return web.Response(text=to_send)


@bot.event
async def on_ready():
    app = web.Application()
    runner = web.AppRunner(app)
    await runner.setup()
    site = web.TCPSite(runner, 'localhost', 8080)
    await site.start()


@commands.command()
async def addenemy(ctx, enemy: str):
    to_send = enemy
    await ctx.send("Sent away!.")


bot.run('TOKEN')

