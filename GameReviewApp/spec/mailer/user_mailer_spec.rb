require 'rails_helper'

describe UserMailer, type: :mailer do
    let(:user){ FactoryBot.create(:user, name: 'メイラー')}

    let(:text_body) do
        part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
        part.body.raw_source
    end
    let(:html_body) do
        part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
        part.body.raw_source
    end

    describe '#creation_email' do
        let(:mail) { UserMailer.creation_email(user) }

        it '想定どおりのメールが生成されている' do
            #ヘッダ
            expect(mail.subject).to eq('ユーザー登録完了メール')
            expect(mail.to).to eq(["#{user.email}"])
            expect(mail.from).to eq(['rkApp@example.com'])

            #text形式の本文
            expect(text_body).to match("#{user.name}様")
            expect(text_body).to match('ユーザー登録完了しました。')
            #html形式の本文
            expect(html_body).to match("#{user.name}様")
            expect(html_body).to match('ユーザー登録完了しました。')
        end
    end
end