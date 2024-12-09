Class {
	#name : #CalibrationLine,
	#superclass : #Object,
	#instVars : [
		'calibrationValue',
		'numbers'
	],
	#category : #'Adventofcode-2024-07'
}

{ #category : #'examples\t\t' }
CalibrationLine class >> aocExample [
	<gtExample>
	| text line |
	text := '190: 10 19'.
	line := self fromText: text.
	self assert: line calibrationValue equals: 190.
	self assert: line numbers equals: #(10 19) asOrderedCollection.
	^ line
]

{ #category : #examples }
CalibrationLine class >> exPossibleValues1 [
	<gtExample>
	| line values |
	line := self aocExample.
	values := line possibleValues.
	self assert: values equals: #(29 190) asSet.
	^ values
]

{ #category : #examples }
CalibrationLine class >> exPossibleValues2 [
	<gtExample>
	| line values |
	line := self fromText: '3267: 81 40 27'.
	values := line possibleValues.
	self assert: values equals: #(148 3267 87480) asSet.
	^ values
]

{ #category : #examples }
CalibrationLine class >> exPossibleValuesPartTwo [
	<gtExample>
	| line values |
	line := self fromText: '7290: 6 8 6 15'.
	values := line possibleValuesForPart: 2.
	self assert: (values includes: 7290).
	^ values
]

{ #category : #'instance creation' }
CalibrationLine class >> fromText: someText [
	| line |
	line := self new.
	line useText: someText.
	^ line
]

{ #category : #accessing }
CalibrationLine class >> partOneEquations [
	^ { [ :a :b | a + b ] . [ :a :b | a * b] }
]

{ #category : #accessing }
CalibrationLine class >> partTwoEquations [
	^ self partOneEquations copyWith: [ :a :b | (a asString , b asString) asNumber ]
]

{ #category : #transformation }
CalibrationLine class >> possibleValuesFor: someNumbers usingEquations: equations withBuffer: aDictionary [
	| last rest subValues possibleValues |
	(someNumbers size = 1) ifTrue: [ ^ Set new add: someNumbers first; yourself ].
	(aDictionary includesKey: someNumbers) ifTrue: [ ^ aDictionary at: someNumbers ].
	last := someNumbers last.
	rest := someNumbers allButLast.
	subValues := self possibleValuesFor: rest usingEquations: equations withBuffer: aDictionary.
	possibleValues := subValues flatCollect: [ :n | equations collect: [ :e | e value: n value: last ] ].
	aDictionary at: someNumbers put: possibleValues.
	^ possibleValues
]

{ #category : #transformation }
CalibrationLine class >> possibleValuesFor: someNumbers withBuffer: aDictionary [
	^ self possibleValuesFor: someNumbers usingEquations: self partOneEquations withBuffer: aDictionary
]

{ #category : #accessing }
CalibrationLine >> calibrationValue [
	^ calibrationValue
]

{ #category : #checking }
CalibrationLine >> isPossible [
	^ self possibleValues includes: calibrationValue.
]

{ #category : #checking }
CalibrationLine >> isPossiblePartTwo [
	^ (self possibleValuesForPart: 2) includes: calibrationValue
]

{ #category : #accessing }
CalibrationLine >> numbers [
	^ numbers
]

{ #category : #transformation }
CalibrationLine >> possibleValues [
	^ self possibleValuesForPart: 1
]

{ #category : #transformation }
CalibrationLine >> possibleValuesForPart: aNumber [
	| buffer equations |
	buffer := Dictionary new.
	(aNumber = 2)
		ifTrue: [ equations := self class partTwoEquations ]
		ifFalse: [ equations := self class partOneEquations ].
	^ self class possibleValuesFor: numbers usingEquations: equations withBuffer: buffer
]

{ #category : #'instance creation' }
CalibrationLine >> useText: aLine [
	| splitLine |
	splitLine := ': ' split: aLine.
	calibrationValue := splitLine first asNumber.
	numbers := (Character space split: splitLine second) collect: [ :n | n asNumber ]
]
