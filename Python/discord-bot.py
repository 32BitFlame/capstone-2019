import discord
from discord.ext import commands


@commands.command()
async def addenemy(ctx, enemy: str):
    await ctx.send("Test.")

bot = commands.Bot(command_prefix='-')

bot.run('TOKEN')

