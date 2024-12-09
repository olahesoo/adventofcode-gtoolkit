Class {
	#name : #CalibrationEquations,
	#superclass : #Object,
	#instVars : [
		'lines'
	],
	#category : #'Adventofcode-2024-07'
}

{ #category : #examples }
CalibrationEquations class >> aocCalibrationResult [
	<gtExample>
	| result |
	result := self aocExample calibrationResult.
	self assert: result equals: 3749.
	^ result
]

{ #category : #examples }
CalibrationEquations class >> aocExample [
	<gtExample>
	| text equations |
	text := '190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
'.
	equations := self fromText: text.
	self assert: equations lines size equals: 9.
	^ equations
]

{ #category : #examples }
CalibrationEquations class >> aocPossibleLines [
	<gtExample>
	| lines |
	lines := self aocExample possibleLines.
	self assert: lines size equals: 3.
	^ lines
]

{ #category : #'instance creation' }
CalibrationEquations class >> fromLines: textLines [
	| equations |
	equations := self new.
	equations useLines: textLines.
	^ equations
]

{ #category : #'instance creation' }
CalibrationEquations class >> fromText: someText [
	| textLines |
	textLines := Client splitLines: someText.
	^ self fromLines: textLines
]

{ #category : #counting }
CalibrationEquations >> calibrationResult [
	^ (self possibleLines collect: [ :l | l calibrationValue ]) sumNumbers
]

{ #category : #counting }
CalibrationEquations >> calibrationResultPartTwo [
	^ (self possibleLinesPartTwo collect: [ :l | l calibrationValue ]) sumNumbers
]

{ #category : #accessing }
CalibrationEquations >> lines [
	^ lines
]

{ #category : #counting }
CalibrationEquations >> possibleLines [
	^ lines select: [ :l | l isPossible ]
]

{ #category : #'as yet unclassified' }
CalibrationEquations >> possibleLinesPartTwo [
	^ lines select: [ :l | l isPossiblePartTwo ]
]

{ #category : #'instance creation' }
CalibrationEquations >> useLines: someLines [
	lines := someLines collect: [ :l | CalibrationLine fromText: l ]
]
