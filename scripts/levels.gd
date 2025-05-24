extends Node

const GateType = preload("res://scripts/gateEnum.gd").Typ

# TODO: create sections i.e. classical, superposition, multibits
const section = {
	0 : "Введение" 
}

const allGates = [
	GateType.Empty, GateType.H, 
	GateType.X, GateType.Y, GateType.Z,
	GateType.Ctrl,
	GateType.S,
]

# level descriptions
const levels = [
	{
		id     = 1,
		desc   = "evaluate intro",
		task   = "Нажмите кнопку  [b]Провести измерение[/b]",
		input  = [0],
		prob   = true,
		output = [
			Vector2(1,0), #0
			Vector2(0,0), #1
		],
		gates  = [GateType.Empty],
		locked = [],
	},
	{
		id     = 2,
		desc   = "X intro",
		task   = "Превратите кубит в состояние [i]|0⟩[/i]",
		input  = [1],
		prob   = true,
		output = [
			Vector2(1,0), #0
			Vector2(0,0), #1
		],
		gates  = [GateType.Empty, GateType.X],
		locked = [],
	},
	{
		id     = 3,
		desc   = "Multi-bits intro",
		task   = "Создайте состояние [i]|10⟩[/i]",
		input  = [0,1],
		prob   = true,
		output = [
			Vector2(0,0), #00
			Vector2(0,0), #01
			Vector2(1,0), #10
			Vector2(0,0), #11
		],
		gates  = [GateType.Empty, GateType.X],
		locked = [],
	},
	{
		id     = 4,
		desc   = "Multi-bits two",
		task   = "Создайте состояние [i]|111⟩[/i]",
		input  = [0,1,0],
		prob   = true,
		output = [
			Vector2(0,0), #000
			Vector2(0,0), #001
			Vector2(0,0), #010
			Vector2(0,0), #011
			Vector2(0,0), #100
			Vector2(0,0), #101
			Vector2(0,0), #110
			Vector2(1,0), #111
		],
		gates  = [GateType.Empty, GateType.X],
		locked = [],
	},
	{
		id     = 5,
		desc   = "Control intro",
		task   = "Создайте состояние [i]|00⟩[/i] поместив элемент control в гейт\n\n" + \
		"Серый блок означает, что он заблокирован и не может быть изменен",
		input  = [0,0],
		prob   = true,
		output = [
			Vector2(1,0), #00
			Vector2(0,0), #01
			Vector2(0,0), #10
			Vector2(0,0), #11
		],
		gates  = [GateType.Empty, GateType.Ctrl],
		locked = [[1,3,GateType.X]],
	},
	{
		id     = 6,
		desc   = "Control more",
		task   = "Создайте состояние [i]|00⟩[/i]",
		input  = [0,1],
		prob   = true,
		output = [
			Vector2(1,0), #00
			Vector2(0,0), #01
			Vector2(0,0), #10
			Vector2(0,0), #11
		],
		gates  = [GateType.Empty, GateType.X, GateType.Ctrl],
		locked = [
			[1,0,GateType.Empty], [1,1,GateType.Empty], [1,2,GateType.Empty],
			[1,4,GateType.Empty], [1,5,GateType.Empty], [1,6,GateType.Empty],
			[1,7,GateType.Empty], [1,8,GateType.Empty], [1,9,GateType.Empty],
			[1,10,GateType.Empty], [1,11,GateType.Empty],
			[1,3,GateType.X], [0,3,GateType.Ctrl], 
		],
	},
	{
		id     = 7,
		desc   = "Больше контроля!",
		task   = "Создайте состояние [i]|100⟩[/i]\n\n" +
"*Гейт может иметь несколько управляющих кубитов и активируется только тогда, когда " +
"все управляющие кубиты находятся в состоянии [i]|1⟩[/i]",
		input  = [0,1,0],
		prob   = true,
		output = [
			Vector2(0,0), #000
			Vector2(0,0), #001
			Vector2(0,0), #010
			Vector2(0,0), #011
			Vector2(1,0), #100
			Vector2(0,0), #101
			Vector2(0,0), #110
			Vector2(0,0), #111
		],
		gates  = [GateType.Empty, GateType.X, GateType.Ctrl],
		locked = [
			[0,0,GateType.Empty],  [0,1,GateType.Empty], [0,2,GateType.Empty],
			[0,3,GateType.Empty],  [0,5,GateType.Empty], [0,6,GateType.Empty],
			[0,7,GateType.Empty],  [0,8,GateType.Empty], [0,9,GateType.Empty],
			[0,10,GateType.Empty], [0,11,GateType.Empty],
			[0,4,GateType.X], [1,4,GateType.Ctrl], [2,4,GateType.Ctrl], 
		],
	},
	{
		id     = 8,
		desc   = "superposition intro",
		task   = "Создайте суперпозицию [i]|0⟩[/i] и [i]|1⟩[/i]",
		input  = [0],
		prob   = true,
		output = [
			Vector2(0.707107,0), #0
			Vector2(0.707107,0), #1
		],
		gates  = [GateType.Empty, GateType.X, GateType.H],
		locked = [],
	},
	{
		id     = 9,
		desc   = "superposition all",
		task   = "Создайте суперпозицию всех двух-кубитных состояний\n\n" \
		+ "Все двух-кубитные состояния это ([i]|00⟩, |01⟩, |10⟩, |11⟩[/i])",
		input  = [0,0],
		prob   = true,
		output = [
			Vector2(0.5,0), #00
			Vector2(0.5,0), #01
			Vector2(0.5,0), #10
			Vector2(0.5,0), #11
		],
		gates  = [GateType.Empty, GateType.X, GateType.H],
		locked = [],
	},
	{
		id     = 10,
		desc   = "superposition",
		task   = "Создайте суперпозицию [i]|01⟩[/i] и [i]|11⟩[/i]",
		input  = [0,0],
		prob   = true,
		output = [
			Vector2(0,0), #00
			Vector2(0.707107,0), #01
			Vector2(0,0), #10
			Vector2(0.707107,0), #11
		],
		gates  = [GateType.Empty, GateType.X, GateType.H],
		locked = [],
	}
]
