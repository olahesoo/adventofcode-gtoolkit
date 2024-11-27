Class {
	#name : #CalibrationDocument,
	#superclass : #Object,
	#instVars : [
		'lines',
		'part'
	],
	#category : #'Adventofcode-2023-01'
}

{ #category : #transformation }
CalibrationDocument class >> calibrationNumbersFrom1: aString [

	^ (aString allRegexMatches: '\d') collect: [ :digit_str | digit_str asInteger ]
]

{ #category : #transformation }
CalibrationDocument class >> calibrationNumbersFrom2: aString [

	^ aString regex: '\d|one|two|three|four|five|six|seven|eight|nine' matchesCollect: [ :match | self spelledNumbers at: match ifAbsent: match asInteger ]
]

{ #category : #'instance creation' }
CalibrationDocument class >> from: text [

	| newDocument lines|
	lines := (Character lf split: text) reject: [ :string | string isEmptyOrNil ].
	newDocument := self new.
	newDocument lines: lines.
	^ newDocument
]

{ #category : #'instance creation' }
CalibrationDocument class >> fromLines: lines [

	| newDocument |
	newDocument := self new.
	newDocument lines: lines.
	^ newDocument
]

{ #category : #defaults }
CalibrationDocument class >> spelledNumbers [

	| numbers |
	numbers := Dictionary new.
	numbers add: 'one' -> 1;
	add: 'two' -> 2;
	add: 'three' -> 3;
	add: 'four' -> 4;
	add: 'five' -> 5;
	add: 'six' -> 6;
	add: 'seven' -> 7;
	add: 'eight' -> 8;
	add: 'nine' -> 9.
	^ numbers
]

{ #category : #transformation }
CalibrationDocument >> calibrationNumbersFrom: aString [

	| numbers |
	part = 1
		ifTrue: [ numbers := self class calibrationNumbersFrom1: aString ]
		ifFalse: [ numbers := self class calibrationNumbersFrom2: aString ].
	^ numbers
]

{ #category : #transformation }
CalibrationDocument >> calibrationValueFrom: aString [

	| numbers |
	numbers := self calibrationNumbersFrom: aString.
	^ numbers first * 10 + numbers last
]

{ #category : #accessing }
CalibrationDocument >> calibrationValues [

	^ self lines collect: [ :line | self calibrationValueFrom: line ]
]

{ #category : #examples }
CalibrationDocument >> createDocument [

	<gtExample>
	<description: 'Create a new calibration document from text input'>
	| exampleText document |
	exampleText := '1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
'.
	document := CalibrationDocument from: exampleText.
	self assert: document lines = #('1abc2' 'pqr3stu8vwx' 'a1b2c3d4e5f' 'treb7uchet') asOrderedCollection.
	^ document
]

{ #category : #examples }
CalibrationDocument >> extractCalibrationValues [

	<gtExample>
	<description: 'Extract numbers from calibration document lines'>
	| values |
	values := self createDocument calibrationValues.
	self assert: values = #(12 38 15 77) asOrderedCollection.
	^ values
]

{ #category : #visualization }
CalibrationDocument >> gtLinesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Lines';
		priority: 10;
		items: [ self lines ];
		column: 'Text' text: [ :aLine | aLine ];
		column: 'Parsed numbers' text: [ :aLine | self calibrationNumbersFrom: aLine ];
		column: 'Calibration value' text: [ :aLine | self calibrationValueFrom: aLine ]
]

{ #category : #initialization }
CalibrationDocument >> initialize [

	part := 1
]

{ #category : #accessing }
CalibrationDocument >> lines [

	^ lines
]

{ #category : #initalization }
CalibrationDocument >> lines: someLines [

	lines := someLines
]

{ #category : #examples }
CalibrationDocument >> parseNumbers2 [

	<gtExample>
	<description: 'Parse numbers according to part 2 rules'>
	| parsedNumbers |
	parsedNumbers := self class calibrationNumbersFrom2: 'two1nine'.
	self assert: parsedNumbers = #(2 1 9) asOrderedCollection.
	^ parsedNumbers
]

{ #category : #accessing }
CalibrationDocument >> part [
	^ part
]

{ #category : #accessing }
CalibrationDocument >> part: anObject [
	part := anObject
]
