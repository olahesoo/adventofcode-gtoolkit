Class {
	#name : #PrintRules,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #'Adventofcode-2024-05'
}

{ #category : #'instance creation' }
PrintRules class >> fromRules: ruleStrings [
	| printRules |
	printRules := self new.
	ruleStrings do: [ :ruleString | printRules addRule: ruleString ].
	^ printRules
]

{ #category : #'as yet unclassified' }
PrintRules >> addRule: ruleLine [
	| splitRule before after |
	splitRule := ($| split: ruleLine) collect: [ :s | s asNumber ].
	before := splitRule first.
	after := splitRule second.
	rules at: before put: ((rules at: before ifAbsent: Set new) add: after; yourself)
]

{ #category : #'as yet unclassified' }
PrintRules >> checkBefore: beforeNumber andAfter: afterNumber [
	^ ((rules at: afterNumber ifAbsent: [ ^ true ]) anySatisfy: [ :n | n = beforeNumber ]) not
]

{ #category : #initialization }
PrintRules >> initialize [
	rules := Dictionary new
]
