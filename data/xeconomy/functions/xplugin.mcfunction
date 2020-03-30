tellraw @a [{"text":"[xEconomy]","color":"green"},{"text":" Successfully Loaded!","color":"white"}]
scoreboard players set xpl xgeneral 0
execute store result score xpl xgeneral run kill @e[tag=xplugin]
tellraw @a ["",{"text":"[xEconomy]","color":"green"},{"text":" Found "},{"score":{"name":"xpl","objective":"xgeneral"}},{"text":" plugin(s)."}]