scoreboard players add @s shopprice 100
tellraw @p[scores={b3=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
scoreboard players set @s b3 0