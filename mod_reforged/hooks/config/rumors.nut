// We add up 4 new variables for texts to be build with.
// Three are wrong distances, direction and terrain for the purpose of creating more interesting rumors.
// One is an indirect adjective for a legendary location if you don't wanna name it directly
// This hook will add those vars for contracts and events aswell but they will not make use of those
local buildTextFromTemplate = ::buildTextFromTemplate;
::buildTextFromTemplate = function( _text, _vars )
{
	foreach (var in _vars)
	{
		if (var[0] == "distance")
		{
			local wrongDistances = ::Const.Strings.Distance.filter(@(_idx, _val) _val != var[1]);
			_vars.push([
				"wrongDistance",
				::MSU.Array.rand(wrongDistances)
			]);
			continue;
		}
		if (var[0] == "direction")
		{
			local wrongDirections = ::Const.Strings.Direction8.filter(@(_idx, _val) _val != var[1]);
			_vars.push([
				"wrongDirection",
				::MSU.Array.rand(wrongDirections)
			]);
			continue;

		}
		if (var[0] == "terrain")
		{
			local wrongTerrains = ::Const.Strings.Terrain.filter(@(_idx, _val) _val != var[1]);
			_vars.push([
				"wrongTerrain",
				::MSU.Array.rand(wrongTerrains)
			]);
			continue;
		}
	}
	_vars.push([
		"legendaryLocationAdjective",
		::MSU.Array.rand(::Const.Strings.LegendaryLocationAdjective)
	])
	return buildTextFromTemplate(_text, _vars);
}

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
		"{I keep hearing talk | Some traveller mentioned something | Some pilgrim mentioned something} about a %legendaryLocationAdjective% {place | location} {%direction% from here | %terrain% | %distance%}"
	],
	[   // Include the exact name but the other information is usually randomly true or fake
		"{An explorer | A cartographer} just recently came by, said he found {a | some} %legendaryLocationAdjective% {place | location} %distance% {that he | } {called | named} %location%. If only some more details slipped out of his mouth...",
		"%randomname% told me \'bout %location% the other day. He said it was {%direction% | %wrongDirection% | %wrongDirection%} from here. {But he was drunk so I wouldn\'t trust his word | I\'m probably remembering it wrong}.",
		"There is an {urban | old} {legend | story} about a {place | location} called %location%. {Some | Some folk} {say | insist} it\'s {%distance% while others estimate it %wrongDistance% | %wrongDistance% while others estimate it %distance%}.",
		"Just {the other day | yesterday | this morning} a drunk guy {was talking | came up to} to me, said he {found | stumbled upon} {a | some} {place | location} called %location% on one of his adventures. First he claimed it was {%direction%, then he corrected himself saying it was %wrongDirection% | %wrongDirection%, then he corrected himself saying it was %direction%}. In the end he {insisted | sweared} on it being {%direction% | %wrongDirection%}",
		"{Some | %randomname%s} kid told me {this | a} story {the other day | yesterday | this morning}. It was about {a | some} {place | location} {he calls | called} %location%. He told me it\'s supposed to be {%distance% | %wrongDistance%} to the {%direction% | %wrongDirection%} from here, {%terrain% | %wrongTerrain%}. You {know, I think that story is | believe any of this? Me neither, it\'s} a load of {horse | horse | horse | horse | unhold} shit."
	]
]
