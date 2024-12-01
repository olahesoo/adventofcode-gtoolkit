Class {
	#name : #DoubleList,
	#superclass : #Object,
	#instVars : [
		'first',
		'second'
	],
	#category : #'Adventofcode-2024-01'
}

{ #category : #transformation }
DoubleList class >> countDict: aCollection [
	| dict |
	dict := Dictionary new.
	aCollection do: [ :value | dict at: value update: [ :count | count + 1] initial: 1 ].
	^ dict
]

{ #category : #'instance creation' }
DoubleList class >> fromLines: lines [
	| doubleList |
	doubleList := self new.
	lines do: [ :line | doubleList addLine: line ].
	^ doubleList
]

{ #category : #'instance creation' }
DoubleList class >> parseLine: aLine [
	| numberStrings |
	numberStrings := (Character space split: aLine) reject: [ :c | c isEmpty ].
	^ numberStrings collect: [ :s | s asNumber ]
]

{ #category : #adding }
DoubleList >> addLine: aLine [
	| numbers |
	numbers := self class parseLine: aLine.
	first add: numbers first.
	second add: numbers second.
]

{ #category : #accessing }
DoubleList >> first [
	^ first
]

{ #category : #initialization }
DoubleList >> initialize [
	first := SortedCollection new.
	second := SortedCollection new
]

{ #category : #accessing }
DoubleList >> second [
	^ second
]

{ #category : #accessing }
DoubleList >> similarityScore [
	| firstCounts secondCounts accumulator |
	firstCounts := self class countDict: first.
	secondCounts := self class countDict: second.
	accumulator := 0.
	firstCounts keysAndValuesDo: [ :key :value |
		accumulator := accumulator +
			(key * value * secondCounts at: key ifAbsent: 0)
	].
	^ accumulator
]

{ #category : #accessing }
DoubleList >> totalDifference [
	^ (first with: second collect: [ :f :s | (f - s) abs ]) sum
]
