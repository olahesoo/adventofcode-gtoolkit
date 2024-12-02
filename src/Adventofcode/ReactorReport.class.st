Class {
	#name : #ReactorReport,
	#superclass : #Object,
	#instVars : [
		'report'
	],
	#category : #'Adventofcode-2024-02'
}

{ #category : #'instance creation' }
ReactorReport class >> fromLine: aLine [
	| reactorReport splitLine numbers|
	reactorReport := self new.
	splitLine := Character space split: aLine.
	numbers := splitLine collect: [ :n | n asNumber ].
	reactorReport report: numbers.
	^ reactorReport
]

{ #category : #'as yet unclassified' }
ReactorReport >> isDampenedSafe [
	| dampenedNumbers dampenedReports |
	dampenedNumbers := (1 to: report size) collect: [ :i | report copy removeAt: i; yourself ].
	dampenedReports := dampenedNumbers collect: [ :n | ReactorReport new report: n ].
	^ dampenedReports anySatisfy: [ :r | r isSafe ]
]

{ #category : #accessing }
ReactorReport >> isSafe [
	| differences |
	differences := report overlappingPairsCollect: [ :a :b | b - a ].
	^ (differences first >= 1)
		ifTrue: [ differences allSatisfy: [ :d | (d >= 1) & (d <= 3) ] ]
		ifFalse: [ differences allSatisfy: [ :d | (d <= -1) & (d >= -3) ] ]
	
]

{ #category : #accessing }
ReactorReport >> report [
	^ report
]

{ #category : #accessing }
ReactorReport >> report: anObject [
	report := anObject
]
