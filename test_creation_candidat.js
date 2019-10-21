describe('creation candidat', function() {
	it('test', function() {
		cy.visit('https://www.welcomekit.co/dashboard/o/dkxzma3/jobs/2XMOI_yq66e6b/new-candidate/392777')		  
		cy.get('input[name=firstname]')
		  .type('karim')
		cy.get('input[name=lastname]')
		  .type('turki')
		cy.get('input[name=subtitle]')
		  .type('developpeur')
		cy.get('input[name=email]')
		  .type('kturki85@gmail.com')
		cy.get('input[name=phone]')
		  .type('0123456789')
		cy.get('input[name=address]')
		  .type('rue blaze')
		cy.get('input[name=city]')
		  .type('Paris')
		cy.get('input[name=zip_code]')
		  .type('75009')
		cy.get('button.btn-primary')
		  .click()

		cy.wait(6000)
		cy.get('div.card-thumbnail-content')
		  .find('ul > li:contains("karim turki")')
		  .click()
		cy.wait(6000)
		cy.get('div.card-header-left') 
		  .find('li.card-header-name > span')
		  .should('have.text', 'karim turki')
		cy.get('div.card-header-left')
		  .find('li.card-header-see-more-wrapper > ul')
		  .find('li.card-header-contact > ul.candidate-infos')
		  .find('li.candidate-infos-email > a')
		  .should('have.text', 'kturki85@gmail.com')
		cy.get('div.card-header-left')
		  .find('li.card-header-see-more-wrapper > ul')
		  .find('li.card-header-contact > ul.candidate-infos')
		  .find('li.candidate-infos-phone > a')
		  .should('have.text', '0123456789')
	})
})