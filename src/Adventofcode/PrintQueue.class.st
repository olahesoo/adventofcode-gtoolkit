Class {
	#name : #PrintQueue,
	#superclass : #Object,
	#instVars : [
		'rules',
		'updates'
	],
	#category : #'Adventofcode-2024-05'
}

{ #category : #examples }
PrintQueue class >> aocExample [
	<gtExample>

	| sampleText printQueue |
	sampleText := Character lf split: '47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47'.
	printQueue := self fromLines: sampleText.
	^ printQueue

]

{ #category : #'instance creation' }
PrintQueue class >> fromLines: someLines [
	^ self new useLines: someLines
]

{ #category : #transformation }
PrintQueue class >> getMiddle: update [
	^ update at: update size // 2 + 1
]

{ #category : #checking }
PrintQueue >> checkUpdate: update [
	1 to: update size do: [ :firstIndex |
		firstIndex + 1 to: update size do: [ :secondIndex |
			(rules checkBefore: (update at: firstIndex) andAfter: (update at: secondIndex))
				ifFalse: [ ^ false ]
		]
	].
	^ true
]

{ #category : #checking }
PrintQueue >> checkUpdates [
]

{ #category : #transformation }
PrintQueue >> fixUpdate: update [
	| updateCopy |
	updateCopy := update copy.
	1 to: updateCopy size do: [ :firstIndex |
		firstIndex + 1 to: updateCopy size do: [ :secondIndex |
			(rules checkBefore: (updateCopy at: firstIndex) andAfter: (update at: secondIndex))
				ifFalse: [ updateCopy swap: firstIndex with: secondIndex ]
		]
	].
	^ updateCopy
]

{ #category : #'as yet unclassified' }
PrintQueue >> fixedUpdates [
	^ self invalidUpdates collect: [ :u | self fixUpdate: u ]
]

{ #category : #'as yet unclassified' }
PrintQueue >> fixedUpdatesSum [
	^ (self fixedUpdates collect: [ :u | self class getMiddle: u ]) sumNumbers
]

{ #category : #'as yet unclassified' }
PrintQueue >> invalidUpdates [
	^ updates reject: [ :u | self checkUpdate: u ]
]

{ #category : #initialization }
PrintQueue >> useLines: inputLines [
	| splitLines |
	splitLines := [ :s | s isEmpty ] split: inputLines.
	rules := PrintRules fromRules: splitLines first.
	updates := splitLines second collect: [ :s | ($, split: s) collect: [ :n | n asNumber ] ]
]

{ #category : #checking }
PrintQueue >> validUpdates [
	^ updates select: [ :u | self checkUpdate: u ]
]

{ #category : #checking }
PrintQueue >> validUpdatesSum [
	^ (self validUpdates collect: [ :u | self class getMiddle: u ]) sumNumbers
]
