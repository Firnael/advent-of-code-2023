# Notes

## Day 5

Pour la part 2, c'est sûrement plus simple de partir du bas et de remonter (traiter les seeds comme une dernière étape).
Donc j'imagine qu'on peut partir de la valeur la plus petit de **destination** de `humidity-to-location`, trouver la source qui correspond, et remonter comme ça en sens inverse.

1. créer les intervalles des seeds.
2. partir d'un **index 0** dans les **destinations** de `humidity-to-location`
3. remonter d'un cran au dessus via le mapping dans l'autre sens
4. si on trouve pas, on garde la valeur et on remonte encore au dessus, jusqu'aux seeds.
5. si on trouve pas dans nos seeds, **on fait ++ sur l'index**, et on continue comme ça comme des cons jusqu'à trouver.

Ça m'a l'air plus opti que du pur brute force, mais est-ce qu'il y aurait pas moyen de commencer plus haut que 0 ?
