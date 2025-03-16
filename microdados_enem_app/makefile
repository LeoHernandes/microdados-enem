.PHONY:

run:
	flutter run --device-connection attached

build-release:
	flutter build apk --release

deploy-firebase:
	firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
	--app 1:1044266129832:android:686d21fbfafffa9e44259d \
	--release-notes "Versão teste" \
	--testers-file "./testers.txt"