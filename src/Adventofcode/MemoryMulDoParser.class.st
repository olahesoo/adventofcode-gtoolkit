Class {
	#name : #MemoryMulDoParser,
	#superclass : #MemoryMulParser,
	#instVars : [
		'do',
		'dont',
		'mixed_operation'
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
	^ mixed_operation star
]

{ #category : #'as yet unclassified' }
MemoryMulDoParser >> mixed_operation [
	^ (do / dont / mul_operation) sea ==> #second
]
