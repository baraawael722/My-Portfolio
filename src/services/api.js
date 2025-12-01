// src/services/api.js
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001';

class ApiService {
  // Projects
  async getProjects() {
    try {
      const response = await fetch(`${API_URL}/api/projects`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching projects:', error);
      return { success: false, error: error.message };
    }
  }

  async getProject(id) {
    try {
      const response = await fetch(`${API_URL}/api/projects/${id}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching project:', error);
      return { success: false, error: error.message };
    }
  }

  async createProject(projectData) {
    try {
      const response = await fetch(`${API_URL}/api/projects`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(projectData),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error creating project:', error);
      return { success: false, error: error.message };
    }
  }

  async updateProject(id, projectData) {
    try {
      const response = await fetch(`${API_URL}/api/projects/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(projectData),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error updating project:', error);
      return { success: false, error: error.message };
    }
  }

  async deleteProject(id) {
    try {
      const response = await fetch(`${API_URL}/api/projects/${id}`, {
        method: 'DELETE',
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error deleting project:', error);
      return { success: false, error: error.message };
    }
  }

  // Certificates
  async getCertificates() {
    try {
      const response = await fetch(`${API_URL}/api/certificates`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching certificates:', error);
      return { success: false, error: error.message };
    }
  }

  async createCertificate(certificateData) {
    try {
      const response = await fetch(`${API_URL}/api/certificates`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(certificateData),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error creating certificate:', error);
      return { success: false, error: error.message };
    }
  }

  // Contact Messages
  async sendContactMessage(messageData) {
    try {
      const response = await fetch(`${API_URL}/api/contact`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(messageData),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error sending message:', error);
      return { success: false, error: error.message };
    }
  }

  async getContactMessages() {
    try {
      const response = await fetch(`${API_URL}/api/contact`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching messages:', error);
      return { success: false, error: error.message };
    }
  }

  // Comments
  async getComments() {
    try {
      const response = await fetch(`${API_URL}/api/comments`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching comments:', error);
      return { success: false, error: error.message };
    }
  }

  async createComment(commentData) {
    try {
      const response = await fetch(`${API_URL}/api/comments`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(commentData),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error creating comment:', error);
      return { success: false, error: error.message };
    }
  }

  async approveComment(id) {
    try {
      const response = await fetch(`${API_URL}/api/comments/${id}/approve`, {
        method: 'PUT',
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error approving comment:', error);
      return { success: false, error: error.message };
    }
  }

  async deleteComment(id) {
    try {
      const response = await fetch(`${API_URL}/api/comments/${id}`, {
        method: 'DELETE',
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error deleting comment:', error);
      return { success: false, error: error.message };
    }
  }
}

export default new ApiService();
