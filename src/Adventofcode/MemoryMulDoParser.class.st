Class {
	#name : #MemoryMulDoParser,
	#superclass : #MemoryMulParser,
	#instVars : [
		'do',
		'dont'
	],
	#category : #'Adventofcode-2024-03'
}

{ #category : #grammar }
MemoryMulDoParser >> do [
	^ 'do()' asPParser
]

{ #category : #grammar }
MemoryMulDoParser >> dont [
	^ 'don''t()' asPParser
]

{ #category : #grammar }
MemoryMulDoParser >> memory [
	^ (do / dont / mixed_mul) star
]

{ #category : #grammar }
MemoryMulDoParser >> mixed_do [
	^ do sea ==> #second
]

{ #category : #grammar }
MemoryMulDoParser >> mixed_dont [
	^ dont sea == #second
]
