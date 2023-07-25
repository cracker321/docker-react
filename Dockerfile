# 오직 배포용 도커파일
# test하려는 용도는 Dockerfile.dev 를 빌드해서 해야 한다. 
# 이 도커파일 빌드해도 test용으로는 할 수 없다!

FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 두 번째 'FROM statement'를 작성하면, 이전의 FROM부터 여기의 FROM 까지의 코드가 모두 완전히 실행되어
# 완료되었음을 전제로 함.
# 즉, 위의 FROM statement 블럭과 이제 구분되는 것임.
FROM nginx

# nginx의 기본 포트 80을 EXPOSE(노출)시켜주고, 그러면 이후 Elastic Beanstalk이 아래 nginx 포트를 자동으로 매핑해줌.
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html






