extends RakugoVar
class_name CharacterObject

var parameters_names : Array = [
	"name",
	"color",
	"prefix",
	"suffix",
	"avatar",
	"stats"
	]

var _color : Color
var _avatar : String

var name  : = "" 
var prefix: = ""
var suffix: = ""
var stats: = {}

var color : String = "#ffffff" setget _set_color, _get_color
var avatar setget _set_avatar, _get_avatar

func _init(var_id:String, var_value:Dictionary
	).(var_id, var_value, Rakugo.Type.CHARACTER) -> void:
	_set_value(_value)

func _set_color(vcolor : String) -> void:
	_color = Color(vcolor)

func _get_color() -> String:
	return _color.to_html()

func _set_avatar(vavatar : Resource) -> void:
	_avatar = vavatar.resource_path

func _get_avatar() -> String:
	return _avatar

func parse_name() -> String:
	var ncharacter = ""

	if name != "":
		ncharacter = "{color=#" + color + "}"
		ncharacter += name
		ncharacter += "{/color}"

	return ncharacter

func parse_what(what : String) -> String:
	return prefix + what + suffix

func _set_value(parameters: = {}) -> void:
	dict2character(parameters)

func _get_value() -> Dictionary:
	return character2dict()

func character2dict() -> Dictionary:
	var dict = {}
	dict["name"]	= name
	dict["color"]	= color
	dict["prefix"]	= prefix
	dict["suffix"]	= suffix
	dict["avatar"]	= _avatar
	dict["stats"]	= stats

	return dict

func dict2character(dict : Dictionary) -> void:
	if dict.has("name"):
		name = dict.name

	if dict.has("color"):
		color = dict.color

	if dict.has("prefix"):
		prefix = dict.prefix

	if dict.has("suffix"):
		suffix = dict.suffix

	if dict.has("avatar"):
		_avatar = dict.avatar

		if dict.has("stats"):
			stats = dict.stats

func parse_text(text:String, open:String, close:String) -> String:
	text = .parse_text(text, open, close)

	for k in character2dict().keys():
		var sa = open +  _id + "." + k + close
		var r = _value[k]

		if k == "name":
			r = parse_name()

		if text.find(sa) == -1:
			continue # no variable in this string

		text = text.replace(sa, r)

	return text
