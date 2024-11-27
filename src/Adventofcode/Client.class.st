Class {
	#name : #Client,
	#superclass : #Object,
	#instVars : [
		'sessionToken',
		'year',
		'day'
	],
	#category : #'Adventofcode-Client'
}

{ #category : #default }
Client class >> getDefaultToken [

	^ '//Users/olahesoo/.tokens/aoc_session' asFileReference contents.
]

{ #category : #'instance creation' }
Client class >> withToken: token [

	| newClient |
	newClient := self new.
	newClient token: token.
	^ newClient
]

{ #category : #accessing }
Client >> day [

	^ day
]

{ #category : #initialization }
Client >> day: newDay [

	day := newDay
]

{ #category : #accessing }
Client >> input [

	| aoc_session_cookie aoc_client input_url |
	aoc_session_cookie := ZnCookie name: 'session' value: self token.
	aoc_session_cookie domain: '.adventofcode.com'.
	aoc_client := ZnClient new.
	aoc_client session cookieJar add: aoc_session_cookie.
	
	input_url := 'https://adventofcode.com/{year}/day/{day}/input' format: (Dictionary new add: #year -> year; add: #day -> day; yourself).
	
	^ aoc_client get: input_url
	
]

{ #category : #acccessing }
Client >> inputLines [

	| lines |
	lines := Character lf split: self input.
	lines removeLast.
	^ lines
]

{ #category : #accessing }
Client >> token [

	sessionToken isNil ifTrue: [ sessionToken := Client getDefaultToken ].
	^ sessionToken
]

{ #category : #initialization }
Client >> token: newToken [

	sessionToken := newToken
]

{ #category : #accessing }
Client >> year [

	^ year
]

{ #category : #initialization }
Client >> year: newYear [

	year := newYear
]

{ #category : #initialization }
Client >> year: newYear day: newDay [

	year := newYear.
	day := newDay
]
