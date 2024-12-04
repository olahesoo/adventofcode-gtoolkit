Class {
	#name : #XmasSearch,
	#superclass : #Object,
	#instVars : [
		'letters'
	],
	#category : #'Adventofcode-2024-04'
}

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
	^ (letters keys select: [ :centerPoint | self checkX_masAt: centerPoint ]) size
]

{ #category : #counting }
XmasSearch >> countXmas [
	^ (letters keys collect: [ :startPoint | 
		((0@0) eightNeighbors select: [ :directionPoint | self searchFor: 'XMAS' startingAt: startPoint inDirection: directionPoint ]) size
	]) sumNumbers
]

{ #category : #initalization }
XmasSearch >> initialize [
	letters := Dictionary new
]

{ #category : #checking }
XmasSearch >> searchFor: word startingAt: startPoint inDirection: directionPoint [
	word withIndexDo: [ :letter :index |
		(self checkLetterAt: (index - 1 * directionPoint + startPoint) for: letter) ifFalse: [ ^ false ]
	].
	^ true
]

{ #category : #'instance creation' }
XmasSearch >> useInputLines: inputLines [
	| inputSize |
	(inputLines size = inputLines first size) ifFalse: [ self error: 'Only square inputs are supported' ].
	inputSize := inputLines size.
	1 to: inputSize do: [ :x |
		1 to: inputSize do: [ :y |
			letters at: (x@y) put: ((inputLines at: y) at: x).
		]
	]
	
]
