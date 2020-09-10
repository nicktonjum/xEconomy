scoreboard players add @s shopprice 10
tellraw @p[scores={b2=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
scoreboard players set @s b2 0