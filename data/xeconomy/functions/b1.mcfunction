scoreboard players add @s shopprice 1
tellraw @p[scores={b1=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
scoreboard players set @s b1 0