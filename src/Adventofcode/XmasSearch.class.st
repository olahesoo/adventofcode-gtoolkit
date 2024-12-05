Class {
	#name : #XmasSearch,
	#superclass : #Object,
	#instVars : [
		'letters',
		'sideLength'
	],
	#category : #'Adventofcode-2024-04'
}

{ #category : #example }
XmasSearch class >> aocExample [
	<gtExample>
	
	| sampleLines xmasSearch |
	sampleLines := Character lf split: 'MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX'.
	xmasSearch := self fromLines: sampleLines.
	self assert: (xmasSearch countXmas = 18).
	self assert: (xmasSearch countX_mas = 9).
	^ xmasSearch
]

{ #category : #'instance creation' }
XmasSearch class >> fromLines: inputLines [
	| xmasSearch |
	xmasSearch := self new.
	xmasSearch useInputLines: inputLines.
	^ xmasSearch
]

{ #category : #checking }
XmasSearch >> checkLetterAt: aPoint for: aCharacter [
	^ (letters at: aPoint ifAbsent: nil) = aCharacter
]

{ #category : #checking }
XmasSearch >> checkX_masAt: centerPoint [
	| defaultTopLeftPoint |
	defaultTopLeftPoint := -1@(-1) + centerPoint.
	{
		defaultTopLeftPoint.
		defaultTopLeftPoint rotateBy: #left centerAt: centerPoint.
		defaultTopLeftPoint rotateBy: #right centerAt: centerPoint.
		defaultTopLeftPoint rotateBy: #pi centerAt: centerPoint.
	} detect: [ :topLeftPoint | self checkX_masAt: centerPoint topLeft: topLeftPoint ] ifFound: [ :_ | ^ true ] ifNone: [ ^ false ]
]

{ #category : #checking }
XmasSearch >> checkX_masAt: centerPoint topLeft: topLeftPoint [
	"Check for exactly the shape of:
	
	M.S
	.A.
	M.S
	"
	(self checkLetterAt: centerPoint for: $A) ifFalse: [ ^ false ].
	(self checkLetterAt: topLeftPoint for: $M) ifFalse: [ ^ false ].
	(self checkLetterAt: (topLeftPoint rotateBy: #left centerAt: centerPoint) for: $M) ifFalse: [ ^ false ].
	(self checkLetterAt: (topLeftPoint rotateBy: #right centerAt: centerPoint) for: $S) ifFalse: [ ^ false ].
	(self checkLetterAt: (topLeftPoint rotateBy: #pi centerAt: centerPoint) for: $S) ifFalse: [ ^ false ].
	^ true
]

{ #category : #counting }
XmasSearch >> countX_mas [
	^ self findX_mas size
]

{ #category : #counting }
XmasSearch >> countXmas [
	^ self findXmas size
]

{ #category : #searching }
XmasSearch >> findX_mas [
	^ letters keys select: [ :centerPoint | self checkX_masAt: centerPoint ]
]

{ #category : #searching }
XmasSearch >> findXmas [
	"Return a collection of arrays in the shape of {startPoint, direction} for the word 'XMAS'"
	^ letters keys flatCollect: [ :startPoint |
		(0@0) eightNeighbors select: [ :directionPoint | self searchFor: 'XMAS' startingAt: startPoint inDirection: directionPoint] thenCollect: [ :directionPoint | {startPoint . directionPoint} ]
	]
]

{ #category : #initalization }
XmasSearch >> initialize [
	letters := Dictionary new
]

{ #category : #accessing }
XmasSearch >> letters [
	^ letters
]

{ #category : #checking }
XmasSearch >> searchFor: word startingAt: startPoint inDirection: directionPoint [
	word withIndexDo: [ :letter :index |
		(self checkLetterAt: (index - 1 * directionPoint + startPoint) for: letter) ifFalse: [ ^ false ]
	].
	^ true
]

{ #category : #accessing }
XmasSearch >> sideLength [
	^ sideLength
]

{ #category : #'instance creation' }
XmasSearch >> useInputLines: inputLines [
	(inputLines size = inputLines first size) ifFalse: [ self error: 'Only square inputs are supported' ].
	sideLength := inputLines size.
	1 to: sideLength do: [ :x |
		1 to: sideLength do: [ :y |
			letters at: (x@y) put: ((inputLines at: y) at: x).
		]
	]
	
]
