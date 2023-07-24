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
COPY --from=builder /app/build /usr/share/nginx/html






