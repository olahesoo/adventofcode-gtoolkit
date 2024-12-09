Class {
	#name : #GuardPosition,
	#superclass : #Object,
	#instVars : [
		'location',
		'direction'
	],
	#category : #'Adventofcode-2024-06'
}

{ #category : #'instace creation' }
GuardPosition class >> fromLocation: aLocation andDirection: aDirection [
	| position |
	position := self new.
	position location: aLocation; direction: aDirection.
	^ position
]

{ #category : #equality }
GuardPosition >> = aPosition [
	^ (location = aPosition location) & (direction = aPosition direction)
]

{ #category : #accessing }
GuardPosition >> direction [
	^ direction
]

{ #category : #accessing }
GuardPosition >> direction: anObject [
	direction := anObject
]

{ #category : #'as yet unclassified' }
GuardPosition >> hash [
	^ 3 * location hash + direction hash
]

{ #category : #accessing }
GuardPosition >> location [
	^ location
]

{ #category : #accessing }
GuardPosition >> location: anObject [
	location := anObject
]

{ #category : #'as yet unclassified' }
GuardPosition >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: location asString;
		nextPut: Character space;
		nextPutAll: direction asString
]
