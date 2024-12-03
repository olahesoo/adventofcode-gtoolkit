Class {
	#name : #MemoryMulParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'digit',
		'mul_number',
		'mul_operation',
		'mixed_mul',
		'memory',
		'expression'
	],
	#category : #'Adventofcode-2024-03'
}

{ #category : #grammar }
MemoryMulParser >> digit [
	^ #digit asPParser
]

{ #category : #grammar }
MemoryMulParser >> expression [
	^ memory end
]

{ #category : #grammar }
MemoryMulParser >> memory [
	^ mixed_mul star
]

{ #category : #grammar }
MemoryMulParser >> mixed_mul [
	^ mul_operation sea ==> #second
]

{ #category : #grammar }
MemoryMulParser >> mul_number [
	^ (digit , digit optional , digit optional) token
		==> [ :token | token value asNumber ]
]

{ #category : #grammar }
MemoryMulParser >> mul_operation [
	^ ('mul(' asPParser , mul_number , $, asPParser , mul_number , $) asPParser)
		==> [ :mul | mul second * mul fourth ]
]

{ #category : #accessing }
MemoryMulParser >> start [
	^ expression
]
