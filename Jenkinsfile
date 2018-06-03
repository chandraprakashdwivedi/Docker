env.docker_username = 'chandraprakashdwivedi'
env.website = 'my-web1'  //

node("docker-test") {
	checkout scm
	
	stage("Integration Test") {
		try {
			sh "docker build -t $website ."
			sh "docker rm -f $website || true"
			sh "docker run -d -p 8080:80 -v ${WORKSPACE}:/var/www/html --name=$website  $website"
	       	}
		catch(e) {
			error "Integration Test failed"
		}finally {
			sh "docker rm -f $website || true
			sh "docker ps -aq | xargs docker rm || true"
			sh "docker images -aq -f dangling=true || true"
		}
		
	}
	
	stage("Build") {
		sh "docker build -t ${docker_username}/${website}:${BUILD_NUMBER} ."
	}
	stage("Publish") {
		withDockerRegistry([credentialsId: 'Dockerhub']) {
			sh "docker push ${docker_username}/${website}:${BUILD_NUMBER}"
		}
	}
}

node("docker-prod") {
	checkout scm
	stage("Production") {
		try {
			sh '''
			SERVICES=$(docker service ls --filter name=${website} --quiet | wc -l)
			if [[ $SERVICES -eq 0 ]]; then
			  docker service create --replica 2 --network mynet --name ${website} -p 8080:80 ${docker_username}/${website}:${BUILD_NUMBER}
			else
			  docker service update --image ${docker_username}/${website}:${BUILD_NUMBER}  ${website}
			fi
			'''
		      }
		catch(e) {
			sh "docker service update --rollback ${website}"
			error "Service update failed in production"
		}finally {
			sh "docker ps -aq | xargs docker rm || true"
		          }
	        }
}
			
