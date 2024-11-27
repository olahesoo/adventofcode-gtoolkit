Class {
	#name : #CubeGameRound,
	#superclass : #Object,
	#instVars : [
		'red',
		'green',
		'blue'
	],
	#category : #'Adventofcode-2023-02'
}

{ #category : #'instance creation' }
CubeGameRound class >> fromString: aString [
	| redMatcher greenMatcher blueMatcher redCount greenCount blueCount round |
	
	redMatcher := RxMatcher forString: '(\d+) red'.
	greenMatcher := RxMatcher forString: '(\d+) green'.
	blueMatcher := RxMatcher forString: '(\d+) blue'.
	(redMatcher search: aString) ifTrue: [ redCount := (redMatcher subexpression: 1) asInteger ] ifFalse: [ redCount := 0 ].
	(greenMatcher search: aString) ifTrue: [ greenCount := (greenMatcher subexpression: 1) asInteger ] ifFalse: [ greenCount := 0 ].
	(blueMatcher search: aString) ifTrue: [ blueCount := (blueMatcher subexpression: 1) asInteger ] ifFalse: [ blueCount := 0 ].
	round := self new.
	round red: redCount.
	round green: greenCount.
	round blue: blueCount.
	^ round
]

{ #category : #equality }
CubeGameRound >> = anObject [
	^ (self red = anObject red) & (self green = anObject green) & (self blue = anObject blue)
]

{ #category : #accessing }
CubeGameRound >> blue [
	^ blue
]

{ #category : #accessing }
CubeGameRound >> blue: aNumber [
	blue := aNumber
]

{ #category : #accessing }
CubeGameRound >> green [
	^ green
]

{ #category : #accessing }
CubeGameRound >> green: aNumber [
	green := aNumber
]

{ #category : #hash }
CubeGameRound >> hash [
	^ (3 *red) + (5 * green) + (7 * blue)
]

{ #category : #example }
CubeGameRound >> partialRoundFromString [
	<gtExample>
	
	| round |
	round := self class fromString: '3 blue, 4 red'.
	self assert: round red = 4.
	self assert: round green = 0.
	self assert: round blue = 3.
	^ round
]

{ #category : #accessing }
CubeGameRound >> red [
	^ red
]

{ #category : #accessing }
CubeGameRound >> red: aNumber [
	red := aNumber
]

{ #category : #example }
CubeGameRound >> roundEquality [
	<gtExample>
	
	| round equalRound |
	round := self class fromString: '1 red, 2 green, 3 blue'.
	equalRound := self class fromString: '1 red, 2 green, 3 blue'.
	self assert: round equals: equalRound.
	self assert: round hash equals: equalRound hash.
	^ round
]

{ #category : #example }
CubeGameRound >> roundFromString [
	<gtExample>
	
	| round |
	round := self class fromString: '1 red, 2 green, 6 blue'.
	self assert: round red = 1.
	self assert: round green = 2.
	self assert: round blue = 6.
	^ round
]
