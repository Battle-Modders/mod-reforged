
::Const.Strings.LegendaryLocationAdjective <- [
	"overwhelming",
	"mystical",
	"mindblowing",
	"never before seen",
	"spectacular",
	"surreal"
];

::Const.Strings.RumorsUniqueLocation <- [
	[   // Doesn't include the name but the information is correct
		"{I keep hearing talk | Some traveller mentioned something | Some pilgrim mentioned something} about a %legendaryLocationAdjective% {place | location} {%direction% from here | %distance% from here %terrain% }"
	],
	[   // Include the exact name but the other information is usually randomly true or fake
		"{An explorer | A cartographer} just recently came by, said he found {a | some} %legendaryLocationAdjective% {place | location} %distance% from here {that he | } {called | named} %location%. If only some more details slipped out of his mouth...",
		"{Some guy from %randomtown% | %randomname%} told me \'bout %location% the other day. He said it was {%direction% | %wrongDirection% | %wrongDirection%} from here. {But he was drunk so I wouldn\'t trust his word | I\'m probably remembering it wrong}.",
		"There is an {urban | old} {tale | legend | story} about a {place | location} called %location%. {Some | Some folk} {say | insist} it\'s {%distance% from here %terrain% while others estimate it %wrongDistance% from here %wrongTerrain% | %wrongDistance% from here %wrongTerrain% while others estimate it %distance% from here %terrain%}.",
		"Just {the other day | yesterday | this morning} a drunk guy {was talking | came up} to me, said he {discovered | found | stumbled upon} {a | some} {place | location} called %location% on one of his adventures. First he claimed it was {%direction%, then he corrected himself saying it was %wrongDirection% | %wrongDirection%, then he corrected himself saying it was %direction%}. In the end he {insisted | sweared} on it being {%direction% | %wrongDirection%}",
		"{Some | %randomname%s} kid told me {this | a} story {the other day | yesterday | this morning}. It was about {a | some} {place | location} {he calls | called} %location%. He told me it\'s supposed to be {%distance% | %wrongDistance%} to the {%direction% | %wrongDirection%} from here, {%terrain% | %wrongTerrain%}. You {know, I think that story is | believe any of this? Me neither, it\'s} a load of {horse | horse | horse | horse | unhold} shit."
	]
]
