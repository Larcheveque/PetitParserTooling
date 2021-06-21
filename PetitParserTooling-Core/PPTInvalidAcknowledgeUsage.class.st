"
I am an exception raised when the pragma <acknowledgeToken:> is badly used.
The only valid use is to have a token like 'aToken' asParser optional or 'aToken' asPParser optional (depending on PetitParser version) and this should not be in a plus or a star in any way.

The following example is invalid:

myRule
			<aknowledgePresence: #aToken>
	^ ruleA, (ruleB, ''aToken'' parser optional) plus
"
Class {
	#name : #PPTInvalidAcknowledgeUsage,
	#superclass : #Error,
	#instVars : [
		'token'
	],
	#category : #'PetitParserTooling-Core-Exceptions'
}

{ #category : #signaling }
PPTInvalidAcknowledgeUsage class >> signalForToken: aToken [
	self new
		token: aToken;
		signal
]

{ #category : #accessing }
PPTInvalidAcknowledgeUsage >> messageText [
	^ 'You try to acknowledge the token: ' , self token
		, ' in an invalid way, look at this exception class comment'
]

{ #category : #accessing }
PPTInvalidAcknowledgeUsage >> token [
	^ token 
]

{ #category : #accessing }
PPTInvalidAcknowledgeUsage >> token: anObject [
	token := anObject
]
