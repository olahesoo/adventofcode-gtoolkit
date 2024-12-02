Class {
	#name : #EngineComponent,
	#superclass : #Object,
	#instVars : [
		'content',
		'row',
		'column'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #example }
EngineComponent class >> createFromTokens [
	<gtExample>
	
	| token component |
	token := EngineParser parseExample first.
	component := self fromToken: token atIndex: 5.
	self assert: component row equals: 5.
	self assert: component column equals: 3.
	self assert: component content equals: 25.
	^ component
]

{ #category : #'instance creation' }
EngineComponent class >> fromToken: aToken atIndex: aNumber [
	| component |
	component := self new.
	component row: aNumber; column: (aToken at: #location); content: (aToken at: #value).
	^ component
]

{ #category : #equality }
EngineComponent >> = aComponent [
	^ (aComponent class = self class)
		ifTrue: [ (self row = aComponent row) & (self column = aComponent column) & (self content = aComponent content) ]
		ifFalse: [ false ]
]

{ #category : #accessing }
EngineComponent >> column [
	^ column
]

{ #category : #accessing }
EngineComponent >> column: anObject [
	column := anObject
]

{ #category : #accessing }
EngineComponent >> content [
	^ content
]

{ #category : #accessing }
EngineComponent >> content: anObject [
	content := anObject
]

{ #category : #accessing }
EngineComponent >> getAdjacentCoordinates [
	| coordinates |
	coordinates := self getCoordinates.
	^ (coordinates flatCollectAsSet: [ :c | c eightNeighbors ]) difference: coordinates
]

{ #category : #accessing }
EngineComponent >> getCoordinates [
	| columns |
	columns := column to: (column + content asString size - 1).
	^ columns collect: [ :c | c @ row ]
]

{ #category : #hashing }
EngineComponent >> hash [
	^ (self row hash * 2) + (self column hash * 3) + (self content hash * 5)
]

{ #category : #'as yet unclassified' }
EngineComponent >> isNumberComponent [
	^ self content isNumber
]

{ #category : #'as yet unclassified' }
EngineComponent >> isSymbolComponent [
	^ self isNumberComponent not
]

{ #category : #printing }
EngineComponent >> printOn: aStream [
	content printOn: aStream.
	aStream nextPutAll: ', '.
	(column @ row) printOn: aStream.
]

{ #category : #accessing }
EngineComponent >> row [
	^ row
]

{ #category : #accessing }
EngineComponent >> row: anObject [
	row := anObject
]

{ #category : #accessing }
EngineComponent >> size [
	^ content asString size
]

{ #category : #example }
EngineComponent >> surroundingCoordinates [
	<gtExample>
	
	| component |
	component := self class createFromTokens.
	self assert: component getAdjacentCoordinates equals: { 2@4 . 3@4 . 4@4 . 5@4 . 2@5 . 5@5 . 2@6 . 3@6 . 4@6 . 5@6 } asSet.
	^ component
]
