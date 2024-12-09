Class {
	#name : #GuardMap,
	#superclass : #Object,
	#instVars : [
		'obstacles',
		'guard',
		'mapRectangle'
	],
	#category : #'Adventofcode-2024-06'
}

{ #category : #examples }
GuardMap class >> aocExample [
	<gtExample>
	| exampleLines |
	exampleLines := Character lf split: '....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...'.
	^ self fromLines: exampleLines
]

{ #category : #examples }
GuardMap class >> aocFirstMove [
	<gtExample>
	| nextPosition |
	nextPosition := self aocExample nextPositionFrom: ( GuardPosition fromLocation: 5@7 andDirection: 0@(-1) ).
	self assert: nextPosition location equals: 5@6.
	self assert: nextPosition direction equals: 0@(-1).
	^ nextPosition
]

{ #category : #examples }
GuardMap class >> aocNoLoopFromDefault [
	<gtExample>
	| map loops |
	map := self aocExample.
	loops := map loopsFrom: map guardStartPosition withObstacles: map obstacles.
	self assert: loops not.
	^ loops
]

{ #category : #examples }
GuardMap class >> aocObstacleChoices [
	<gtExample>
	| choices |
	choices := self aocExample extraObstacleLocations.
	self assert: choices size equals: 6.
	^ choices
]

{ #category : #examples }
GuardMap class >> aocPatrolledLocations [
	<gtExample>
	| patrolledLocations |
	patrolledLocations := self aocExample patrolledLocations.
	^ patrolledLocations
]

{ #category : #examples }
GuardMap class >> aocPatrolledLocationsCount [
	<gtExample>
	| patrolledLocationsCount |
	patrolledLocationsCount := self aocExample patrolledLocationsCount.
	self assert: patrolledLocationsCount equals: 41.
	^ patrolledLocationsCount
]

{ #category : #'instance creation' }
GuardMap class >> fromLines: inputLines [
	| guardMap |
	guardMap := self new.
	guardMap useLines: inputLines.
	^ guardMap
]

{ #category : #moving }
GuardMap class >> nextPositionFrom: position withBounds: aRectangle andObstacles: obstacles [
	| location direction nextLocation |
	location := position location.
	direction := position direction.
	nextLocation := location + direction.
	(aRectangle containsPoint: nextLocation) ifFalse: [ ^ nil ].
	(obstacles includes: nextLocation) ifTrue: [ ^ GuardPosition fromLocation: location andDirection: (direction rotateBy: #right centerAt: 0@0) ].
	^ GuardPosition fromLocation: nextLocation andDirection: direction
]

{ #category : #checking }
GuardMap >> extraObstacleLocations [
	| guardLocations |
	guardLocations := self patrolledLocations copyWithout: self guardStartPosition location.
	^ guardLocations select: [ :location | self loopsFrom: self guardStartPosition withObstacles: (obstacles copyWith: location) ]
]

{ #category : #accessing }
GuardMap >> guardStartPosition [
	^ GuardPosition fromLocation: guard andDirection: 0@(-1)
]

{ #category : #initiailization }
GuardMap >> initialize [
	super initialize.
	obstacles := Set new
]

{ #category : #checking }
GuardMap >> loopsFrom: aPosition withObstacles: someObstacles [
	| guardPosition patrolledPositions |
	patrolledPositions := Set new.
	guardPosition := aPosition.
	[ guardPosition isNotNil ] whileTrue: [
		(patrolledPositions includes: guardPosition) ifTrue: [ ^ true ].
		patrolledPositions add: guardPosition.
		guardPosition := self nextPositionFrom: guardPosition withObstacles: someObstacles
	].
	^ false
]

{ #category : #checking }
GuardMap >> loopsWithObstacleAt: aLocation [
	^ self loopsFrom: self guardStartPosition withObstacles: (obstacles copyWith: aLocation)
]

{ #category : #moving }
GuardMap >> nextPositionFrom: aPosition [
	^ self nextPositionFrom: aPosition withObstacles: obstacles
]

{ #category : #moving }
GuardMap >> nextPositionFrom: aPosition withObstacles: someObstacles [
	^ self class nextPositionFrom: aPosition withBounds: mapRectangle andObstacles: someObstacles
]

{ #category : #counting }
GuardMap >> obstacleChoiceCount [
	^ self extraObstacleLocations size
]

{ #category : #accessing }
GuardMap >> obstacles [
	^ obstacles
]

{ #category : #moving }
GuardMap >> patrolledLocations [
	^ self patrolledPositions collect: [ :p | p location ]
]

{ #category : #counting }
GuardMap >> patrolledLocationsCount [
	^ self patrolledLocations size
]

{ #category : #moving }
GuardMap >> patrolledPositions [
	| guardPosition patrolledPositions |
	patrolledPositions := Set new.
	guardPosition := GuardPosition fromLocation: guard andDirection: 0@(-1).
	[ guardPosition isNotNil ] whileTrue: [
		patrolledPositions add: guardPosition.
		guardPosition := self nextPositionFrom: guardPosition.
	].
	^ patrolledPositions
]

{ #category : #'instance creation' }
GuardMap >> useLines: inputLines [
	| parser tokenLines |
	mapRectangle := (0@0) corner: inputLines first size + 1 @ (inputLines size + 1).
	parser := GuardLineParser new optimize.
	tokenLines := inputLines collect: [ :line | parser parse: line ].
	tokenLines withIndexDo: [ :tokens :lineIndex |
		tokens do: [ :token |
			(token value = '#') ifTrue: [ obstacles add: token start @ lineIndex ].
			(token value = '^') ifTrue: [ guard := token start @ lineIndex ]
		]
	]
]
