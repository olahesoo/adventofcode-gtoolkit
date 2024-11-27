Class {
	#name : #CubeGame,
	#superclass : #Object,
	#instVars : [
		'rounds',
		'id'
	],
	#category : #'Adventofcode-2023-02'
}

{ #category : #'instance creation' }
CubeGame class >> fromString: aString [

	| gameMatcher gameId gameData rounds game|
	gameMatcher := RxMatcher forString: 'Game (\d+)\: (.*)'.
	gameMatcher search: aString.
	gameId := (gameMatcher subexpression: 2) asInteger.
	gameData := gameMatcher subexpression: 3.
	rounds := ('; ' split: gameData) collect: [ :roundData | CubeGameRound fromString: roundData ].
	game := self new.
	game id: gameId.
	game rounds: rounds.
	^ game
]

{ #category : #example }
CubeGame >> gameFromString [
	<gtExample>
	
	| game expectedRounds |
	expectedRounds := OrderedCollection new.
	expectedRounds 
		add: (CubeGameRound fromString: '3 blue, 4 red');
		add: (CubeGameRound fromString: '1 red, 2 green, 6 blue');
		add: (CubeGameRound fromString: '2 green').
	game := CubeGame fromString: 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'.
	self assert: game id equals: 1.
	self assert: game rounds equals: expectedRounds.
	^ game
]

{ #category : #example }
CubeGame >> gameIsPossible [
	<gtExample>
	
	| game |
	game := self minCounts.
	self assert: game possible.
	^ game
]

{ #category : #example }
CubeGame >> gameNotPossible [
	<gtExample>
	
	| game |
	game := self class fromString: 'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red'.
	self assert: game possible not.
	^ game
]

{ #category : #example }
CubeGame >> gamePower [
	<gtExample>
	
	| game |
	game := self minCounts.
	self assert: game power equals: 48.
	^ game
]

{ #category : #accessing }
CubeGame >> id [
	^ id
]

{ #category : #accessing }
CubeGame >> id: anObject [
	id := anObject
]

{ #category : #accessing }
CubeGame >> minBlue [
	^ (rounds collect: [ :round | round blue ]) max
]

{ #category : #example }
CubeGame >> minCounts [
	<gtExample>
	
	| game |
	game := self gameFromString.
	self assert: game minRed equals: 4.
	self assert: game minGreen equals: 2.
	self assert: game minBlue equals: 6.
	^ game
]

{ #category : #accessing }
CubeGame >> minGreen [
	^ (rounds collect: [ :round | round green ]) max
]

{ #category : #accessing }
CubeGame >> minRed [
	^ (rounds collect: [ :round |  round red ]) max
]

{ #category : #accessing }
CubeGame >> possible [
	^ (self minRed <= 12) & (self minGreen <= 13) & (self minBlue <= 14)
]

{ #category : #accessing }
CubeGame >> power [
	^ self minRed * self minGreen * self minBlue
]

{ #category : #accessing }
CubeGame >> rounds [
	^ rounds
]

{ #category : #accessing }
CubeGame >> rounds: anObject [
	rounds := anObject
]
