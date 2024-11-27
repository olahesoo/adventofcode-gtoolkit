Class {
	#name : #EngineParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'empty',
		'number',
		'symbol',
		'expression'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #example }
EngineParser class >> parseExample [
	<gtExample>
	
	| tokens |
	tokens := self parse: '..25.*.4@..$..'.
	self assert: tokens size equals: 5.
	self assert: tokens first equals: (Dictionary newFromKeys: #(#location #value) andValues: {(3 to: 4) . 25}).
	^ tokens
]

{ #category : #grammar }
EngineParser >> empty [
	^ $. asPParser star
]

{ #category : #grammar }
EngineParser >> expression [
	^ (number / symbol) star end
]

{ #category : #grammar }
EngineParser >> number [
	^ (#digit asPParser plus token trim: empty)
		==> [ :nToken | 
			Dictionary
				newFromKeys: #('location' 'value')
				andValues: {nToken start to: nToken stop.
						nToken value asNumber} ]
]

{ #category : #accessing }
EngineParser >> start [
	^ expression
]

{ #category : #grammar }
EngineParser >> symbol [
	^ (#any asPParser token trim: empty)
		==> [ :sToken | 
			Dictionary
				newFromKeys: #('location' 'value')
				andValues: {sToken start to: sToken stop.
						sToken value} ]
]
