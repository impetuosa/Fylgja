Class {
	#name : #FylgjaSystemRuleInstaller,
	#superclass : #FylgjaNorthwindRuleInstaller,
	#category : #'Fylgja-Rule-Installer-Northwind'
}

{ #category : #general }
FylgjaSystemRuleInstaller >> installRules [
	super installRules. 
	" By default in the system we copy"

	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.


]
