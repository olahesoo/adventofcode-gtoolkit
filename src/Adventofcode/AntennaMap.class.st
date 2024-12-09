Class {
	#name : #AntennaMap,
	#superclass : #Object,
	#instVars : [
		'antennas',
		'mapRectangle'
	],
	#category : #'Adventofcode-2024-08'
}

{ #category : #calculating }
AntennaMap class >> antinodesfor: firstPoint and: secondPoint [
	| difference |
	difference := secondPoint - firstPoint.
	^ { firstPoint - difference . secondPoint + difference } asSet
]

{ #category : #examples }
AntennaMap class >> aocExample [
	<gtExample>
	| text map |
	text := '............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
'.
	map := self fromLines: (Client splitLines: text).
	^ map
]

{ #category : #'instance creation' }
AntennaMap class >> fromLines: someLines [
	| map |
	map := self new.
	map useLines: someLines.
	^ map
]

{ #category : #calculating }
AntennaMap >> antinodes [
	^ antennas flatCollectAsSet: [ :frequency |
		frequency flatCollect: [ :first |
			(frequency copyWithout: first) flatCollect: [ :second |
				self class antinodesfor: first and: second
			]
		]
	]
]

{ #category : #selecting }
AntennaMap >> antinodesWithinBounds [
	^ self antinodes select: [ :n | mapRectangle containsPoint: n ]
]

{ #category : #counting }
AntennaMap >> countAntinodes [
	^ self antinodesWithinBounds size
]

{ #category : #counting }
AntennaMap >> countResonantAntinodes [
	^ self resonantAntinodes size
]

{ #category : #initialization }
AntennaMap >> initialize [
	antennas := Dictionary new
]

{ #category : #calculating }
AntennaMap >> resonantAntinodes [
	^ antennas flatCollectAsSet: [ :frequency |
		frequency flatCollect: [ :first |
			(frequency copyWithout: first) flatCollect: [ :second |
				self resonantAntinodesFor: first and: second
			]
		]
	]
]

{ #category : #calculating }
AntennaMap >> resonantAntinodesFor: firstPoint and: secondPoint [
	| antinodes difference candidatePoint |
	antinodes := Set new add: firstPoint; add: secondPoint; yourself.
	difference := secondPoint - firstPoint.
	candidatePoint := firstPoint - difference.
	[ mapRectangle containsPoint: candidatePoint ] whileTrue: [
		antinodes add: candidatePoint.
		candidatePoint := candidatePoint - difference
	].
	candidatePoint := secondPoint + difference.
	[ mapRectangle containsPoint: candidatePoint ] whileTrue: [
		antinodes add: candidatePoint.
		candidatePoint := candidatePoint + difference
	].
	^ antinodes
]

{ #category : #'instance creation' }
AntennaMap >> useLines: someLines [
	| parser |
	mapRectangle := (1@1) corner: (someLines first size + 1) @ (someLines size + 1).
	parser := AntennaParser new optimize.
	someLines withIndexDo: [ :line :index |
		| tokens |
		tokens := parser parse: line.
		tokens do: [ :token |
			| value location |
			value := token value.
			location := token start @ index.
			antennas at: value
				ifPresent: [ :s | s add: location ]
				ifAbsentPut: (Set new add: location; yourself)
		]
	]
]
