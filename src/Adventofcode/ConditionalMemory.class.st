Class {
	#name : #ConditionalMemory,
	#superclass : #Object,
	#instVars : [
		'memory',
		'mul_enabled'
	],
	#category : #'Adventofcode-2024-03'
}

{ #category : #'instance creation' }
ConditionalMemory class >> fromInput: input [
	| conditionalMemory |
	conditionalMemory := self new.
	conditionalMemory memory: (MemoryMulDoParser new optimize parse: input).
	^ conditionalMemory
]

{ #category : #execution }
ConditionalMemory >> enabledMulSum [
	^ self process_memory sumNumbers
]

{ #category : #execution }
ConditionalMemory >> execute: instruction [
	instruction = 'do()' ifTrue: [ mul_enabled := true. ^ 0 ].
	instruction = 'don''t()' ifTrue: [ mul_enabled := false. ^ 0 ].
	"instruction is a multiplication result"
	mul_enabled ifTrue: [ ^ instruction ] ifFalse: [ ^ 0 ]
]

{ #category : #initiailization }
ConditionalMemory >> initialize [
	mul_enabled := true
]

{ #category : #accessing }
ConditionalMemory >> memory: anObject [
	memory := anObject
]

{ #category : #execution }
ConditionalMemory >> process_memory [
	mul_enabled := true.
	^ memory collect: [ :i | self execute: i ]
]
