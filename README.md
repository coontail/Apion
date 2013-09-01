#Apion

Easy-to-use French => Phonetic Alphabet translator

~~~
gem install apion
~~~

~~~
require "apion"
~~~


*Examples* :

~~~
irb(main):002:0> Apion.apion("Le chat dodu et roux mange une quiche aux lardons")
=> ["lœ", "ʃa", "dɔdy", "e", "ru", "mɑ̃ʒ", "yn", "kiʃ", "o", "lardɔ̃"]
~~~

*Automatic ponctuation removal* :

~~~
irb(main):003:0> Apion.apion("Le chat dodu et roux mange ? Oh ! C'est une belle quiche aux lardons !!!")
=> ["lœ", "ʃa", "dɔdy", "e", "ru", "mɑ̃ʒ", "o", "sɛ", "yn", "bɛl", "kiʃ", "o", "lardɔ̃"]
~~~

*Handles both existing and non-existing words*

~~~
irb(main):004:0> Apion.apion("Un chat dodu")
=> ["œ̃", "ʃa", "dɔdy"]

irb(main):005:0> Apion.apion("Un chat toudouchoubidou")
=> ["œ̃", "ʃa", "tuduʃubidu"]
~~~


***Important : All IPA characters can't be displayed in this README, so the translation can be slightly off***
