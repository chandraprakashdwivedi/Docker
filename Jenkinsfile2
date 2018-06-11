#!groovy

env.docker_username = 'chandraprakashdwivedi'
env.website = 'my-web1'  

node("docker-prod") {
	checkout scm //This is used to clone the repository in workspace
	
	stage("Integration Test") {
		try {
			sh "docker build -t $website ."
			sh "docker rm -f $website || true"
			docker service create --replica 2 --network mynet --name ${website} -p 8080:80 ${docker_username}/${website}:${BUILD_NUMBER}
	       	}
		catch(e) {
			error "Integration Test failed"
		}finally {
			sh "docker rm -f $website || true
			sh "docker ps -aq | xargs docker rm || true"
			sh "docker images -aq -f dangling=true || true"
		}
		
	}
	
